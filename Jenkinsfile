pipeline {
    agent any
    
   parameters {
  choice choices: ['dev,qa,prod'], description: 'Select the inventory environment', name: 'env'
}

environment{
    export ANSIBLE_CONFIG=/var/lib/jenkins/workspace/Ansibleconfiguration/inventory/${env}_ansible.cfg

    }


    stages {
        stage('Git Clone') {
            steps {
                git branch: 'main',
                    credentialsId: 'Github-Cred',
                    url: 'https://github.com/srinivasulu762/Configuration-ansible.git'
            }
        }

        stage('Remote Connection Check') {
            steps {
                withCredentials([sshUserPrivateKey(
                    credentialsId: 'ansible-ssh', 
                    keyFileVariable: 'ssh', 
                    usernameVariable: 'username'
                )]) {
                    script {
                        echo "Using keyfile: ${ssh}, username: ${username}"
                        def result = sh(
                            script: "ansible all -m ping --private-key \"${ssh}\"",
                            returnStatus: true
                        )
                        if (result != 0) {
                            error "❌ Remote connection check failed. Please check the connection or inventory."
                        } else {
                            echo "✅ Remote connection check succeeded."
                        }
                    }
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                ansiblePlaybook(
                    credentialsId: 'ansible-ssh',
                    installation: 'ansible-1.0',
                    playbook: 'playbook/httpd.yaml'
                )
            }
        }
    }
}