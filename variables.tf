variable "aws_region" {
    type = string
    default = "us-east-2"
}
variable "schedule_window" {
  description ="agendamento cron windows"
}
variable "cutoff_point_window"{
  description="ponto de interrupcao antes do fechamento da janela"
}
variable "duration_window"{
  description="duracao da janela"
}

variable "environment" {
   description = "Variavel de ambiente"
}