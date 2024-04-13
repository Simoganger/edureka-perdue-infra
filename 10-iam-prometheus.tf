data "aws_iam_policy_document" "prometheus_devl" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:monitoring:prometheus"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "prometheus_devl" {
  assume_role_policy = data.aws_iam_policy_document.prometheus_devl.json
  name               = "prometheus-devl"
}

resource "aws_iam_policy" "prometheus_devl_ingest_access" {
  name = "PrometheusDevlIngestAccess"

  policy = jsonencode({
    Statement = [{
      Action = [
        "aps:RemoteWrite"
      ]
      Effect   = "Allow"
      Resource = aws_prometheus_workspace.devl.arn
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "prometheus_devl_ingest_access" {
  role       = aws_iam_role.prometheus_devl.name
  policy_arn = aws_iam_policy.prometheus_devl_ingest_access.arn
}

# OPTIONAL: only if you have standalone EC2 instances to scare
resource "aws_iam_role_policy_attachment" "prometheus_ec2_access" {
  role       = aws_iam_role.prometheus_devl.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
