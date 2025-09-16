pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
                git branch: 'main',
                    credentialsId: 'Github-Cred',
                    url: 'https://github.com/srinivasulu762/Configuration-ansible.git'
            }
        }

        stage('Run AWS Configuration Playbook') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'Aws_cli',
                     accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']
                ]) {
                    sh '''
                        pip install --upgrade pip

                        pip install boto3 botocore
                        ansible-galaxy collection install amazon.aws
                        ansible-playbook aws/ec2.yaml
                    '''
                }
            }
        }
    }
}
