provider "aws" {
  shared_credentials_file = "aws credentials path"
  region                  = "region"
  profile                 = "name"
}
resource "aws_cloudwatch_metric_alarm" "Memory-Utilization-High" {
    alarm_name = "Memory-Utilization-high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "MemoryUtilization"
    namespace = "System/Linux"
    period = "120"
    statistic = "Average"
    threshold = "80"
    alarm_description = "This alarm monitors memory utilization on ec2"
    alarm_actions = ["${var.sns-notify}"]

    dimensions = {
    InstanceId = "${var.instaceid}"
  }
}
resource "aws_cloudwatch_metric_alarm" "CPU-Utilization-High" {
  alarm_name                = "CPU-Utilization-High"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions = ["${var.sns-notify}"]
  insufficient_data_actions = []

  dimensions = {
    InstanceId = "${var.instaceid}"
  }
}
resource "aws_cloudwatch_metric_alarm" "Disk-Utilization-High" {
  alarm_name                = "Disk-Utilization-High"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "DiskSpaceUtilization"
  namespace                 = "System/Linux"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 disk utilization"
  alarm_actions = ["${var.sns-notify}"]
  insufficient_data_actions = []

  dimensions = {
    MountPath = "/"
    Filesystem = "/dev/nvme0n1p1"
    InstanceId = "${var.instaceid}"
  }
}