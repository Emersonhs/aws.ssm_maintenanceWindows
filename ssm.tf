resource "aws_ssm_maintenance_window" "ssm_window" {
  name     = "ssm_window"
  schedule = var.schedule_window
  duration = var.duration_window
  cutoff   = var.cutoff_point_window
  schedule_timezone = "Brazil/East"

  
  tags = {
    Environment = "Test"
    Name        = "Provider Tag"
  }
  
}
resource "aws_ssm_maintenance_window_target" "ssm_target" {
  window_id     = aws_ssm_maintenance_window.ssm_window.id
  name          = "ssm-target"
  description   = "Maquinas de Destino para ssm"
  resource_type = "INSTANCE"

  targets {
    key    = "tag:Name"
    values = ["ssm"]
  }
}
resource "aws_ssm_maintenance_window_task" "ssm_task" {
  max_concurrency = "100%"
  max_errors      = "0%"
  priority        = 1
  name            = "ssmTaks"
  task_arn        = "${aws_ssm_document.ssmDocument-RunCommand.name}"
  task_type       = "RUN_COMMAND"
  window_id       = aws_ssm_maintenance_window.ssm_window.id


  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.ssm_target.id]
  }

  task_invocation_parameters {
    run_command_parameters {
      output_s3_bucket     = aws_s3_bucket.s3_ssm.bucket
      output_s3_key_prefix = "ssmS3"
      #service_role_arn     = aws_iam_role.example.arn
      timeout_seconds      = 600
    }
  }
}

resource "aws_ssm_document" "ssmDocument-RunCommand" {
  name          = "ssmDocument"
  document_type = "Command"
  document_format = "JSON"
  target_type = "/AWS::EC2::Instance"
  content = <<DOC
  {
    "schemaVersion": "1.2",
    "description": "Check ip configuration of a Linux instance.",
    "parameters": {

    },
    "runtimeConfig": {
      "aws:runShellScript": {
        "properties": [
          {
            "id": "0.aws:runShellScript",
            "runCommand": ["ifconfig"]
          }
        ]
      }
    }
  }
DOC
}