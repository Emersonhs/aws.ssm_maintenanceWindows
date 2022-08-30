# aws.ssm_maintenanceWindows

codigo terraform cria aws ssm Maintenace Window, para execução de algum escript de forma automatizada em um grupo de EC2

o codigo cria na aws:
 S3 - para geração dos logs de cada execução agendada.
 maintenance Windows - com as configurações da janela de execução
 Document - Ducumento na aws com o codigo a ser executado na instacia
 target - um target de instacias que receberão o comando
 task -  resposnavel por agendar tudo e executar o Ducumento