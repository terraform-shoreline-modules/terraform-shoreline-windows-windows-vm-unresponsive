resource "shoreline_notebook" "unresponsive_windows_ec2_instance_on_aws_with_rdp_connection_issue" {
  name       = "unresponsive_windows_ec2_instance_on_aws_with_rdp_connection_issue"
  data       = file("${path.module}/data/unresponsive_windows_ec2_instance_on_aws_with_rdp_connection_issue.json")
  depends_on = [shoreline_action.invoke_log_errors_warnings]
}

resource "shoreline_file" "log_errors_warnings" {
  name             = "log_errors_warnings"
  input_file       = "${path.module}/data/log_errors_warnings.sh"
  md5              = filemd5("${path.module}/data/log_errors_warnings.sh")
  description      = "Check the EC2 instance's system and application logs for any errors or warnings that could provide clues to the cause of the unresponsiveness and RDP connection issue."
  destination_path = "/agent/scripts/log_errors_warnings.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_log_errors_warnings" {
  name        = "invoke_log_errors_warnings"
  description = "Check the EC2 instance's system and application logs for any errors or warnings that could provide clues to the cause of the unresponsiveness and RDP connection issue."
  command     = "`chmod +x /agent/scripts/log_errors_warnings.sh && /agent/scripts/log_errors_warnings.sh`"
  params      = ["REGION","INSTANCE_ID","LOG_FILE_PATH_AND_NAME"]
  file_deps   = ["log_errors_warnings"]
  enabled     = true
  depends_on  = [shoreline_file.log_errors_warnings]
}

