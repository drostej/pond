resource "aws_cloudwatch_dashboard" "devops_guru_dashboard" {
  dashboard_name = "devops-guru-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x    = 0,
        y    = 0,
        width = 6,
        height = 6,
        properties = {
          view     = "singleValue", # ← für Number Widget
          region   = "eu-central-1",
          title    = "DevOps Guru Reactive Insights",
          metrics  = [
            [ "AWS/DevOps_Guru", "Insights", "Type", "reactive" ]
          ],
          stat     = "Sum",
          period   = 3600,
          yAxis    = {
            left = {
              label = "Anzahl"
            }
          }
        }
      }
    ]
  })
}
