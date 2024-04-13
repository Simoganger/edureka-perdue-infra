resource "aws_cloudwatch_log_group" "prometheus_devl" {
  name              = "/aws/prometheus/devl"
  retention_in_days = 14
}

resource "aws_prometheus_workspace" "devl" {
  alias = "devl"

  logging_configuration {
    log_group_arn = "${aws_cloudwatch_log_group.prometheus_devl.arn}:*"
  }
}
