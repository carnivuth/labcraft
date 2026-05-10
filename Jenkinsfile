pipeline {
  agent any

    environment {
      ANSIBLE_HOST_KEY_CHECKING = 'False'
        ANSIBLE_FORCE_COLOR       = 'true'
        ANSIBLE_STDOUT_CALLBACK   = 'yaml'

        // Inventory path per environment
        INVENTORY = "inventory/inventory.proxmox.yml"

        // SSH key stored as a Jenkins credential (type: SSH Username with private key)
        SSH_CREDENTIAL_ID = "ansible-ssh-key"

        // Optional: vault password stored as a Jenkins secret text credential
        VAULT_CREDENTIAL_ID = 'ansible-vault-password'
    }

  options {
    timestamps()
      ansiColor('xterm')
      buildDiscarder(logRotator(numToKeepStr: '30'))
      timeout(time: 60, unit: 'MINUTES')
      disableConcurrentBuilds()
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Install ansible and ansible dependencies') {
      steps {
        sh '''
          python3 -m venv env
          source env/bin/activate
          pip install -r requirements.txt
          ansible-galaxy collection install -r requirements.yml
          ansible-galaxy role install -r requirements.yml
          '''
      }
    }

    stage('Lint') {
      steps {
        sh "ansible-lint playbooks/ || true"
      }
    }

    stage('Run service playbook') {
      steps {
        when {
          oneOf {
            changeset "playbooks/files/services/**"
            changeset "playbooks/service.yml"
          }
        }
        withCredentials([
            sshUserPrivateKey(
              credentialsId: env.SSH_CREDENTIAL_ID,
              keyFileVariable: 'SSH_KEY_FILE',
              usernameVariable: 'SSH_USER'
              ),
            string(
              credentialsId: env.VAULT_CREDENTIAL_ID,
              variable: 'VAULT_PASSWORD'
              )
        ]) {
          script {
            sh "source env/bin/activate; ansible-playbook -i ${INVENTORY} playbooks/service.yml --user=${SSH_USER} --private-key=${SSH_KEY_FILE}"
          }
        }
      }
    }
  }

  post {
    always {
        cleanWs()
    }
    success {
      echo "Playbook ${params.PLAYBOOK} completed successfully on ${params.ENVIRONMENT}."
    }
    failure {
      echo "Playbook ${params.PLAYBOOK} FAILED on ${params.ENVIRONMENT}."
    }
  }
}
