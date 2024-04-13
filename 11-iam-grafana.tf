data "aws_iam_policy_document" "grafana_devl" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:monitoring:grafana"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "grafana_devl" {
  assume_role_policy = data.aws_iam_policy_document.grafana_devl.json
  name               = "grafana-devl"
}

resource "aws_iam_role_policy_attachment" "grafana_devl_query_access" {
  role       = aws_iam_role.grafana_devl.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPrometheusQueryAccess"
}
