pipeline {
  agent any
  stages {
    stage('Cleanup Old Files') {
      steps {
        sh 'sh "sshpass -p \'${env.PASSWORD}\' ssh ${env.USERNAME}@${env.SERVER} \'find ${env.FILE_PATH} -type f -mtime +${env.DAYS_TO_KEEP} -delete\'"'
      }
    }

  }
  environment {
    SERVER = '192.168.137.136'
    USERNAME = 'root'
    PASSWORD = 'p'
    FILE_PATH = '/root/wel*.txt'
    DAYS_TO_KEEP = '10'
  }
}