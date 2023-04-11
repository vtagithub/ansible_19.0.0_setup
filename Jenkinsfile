pipeline {
    agent any
    environment {
        SERVER = '192.168.137.136'  // Replace with your Linux server IP
        USERNAME = 'root'  // Replace with your Linux server username
        PASSWORD = 'p'  // Replace with your Linux server password
        FILE_PATH = '/root/welc*.txt'  // Replace with the path to the directory containing files to be cleaned up
        DAYS_TO_KEEP = 10  // Replace with the number of days after which the files should be cleaned up
    }
    stages {
        stage('Cleanup old files') {
            steps {
                sh "sshpass -p '${env.PASSWORD}' ssh ${env.USERNAME}@${env.SERVER} 'find ${env.FILE_PATH} -type f -mtime +${env.DAYS_TO_KEEP} -delete'"
            }
        }
    }
}
