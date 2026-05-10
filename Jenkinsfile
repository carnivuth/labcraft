pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'staging', 'prod'],
            description: 'Target environment to deploy to'
        )
        choice(
            name: 'PLAYBOOK',
            choices: ['site.yml', 'deploy.yml', 'rollback.yml', 'maintenance.yml'],
            description: 'Ansible playbook to run'
        )
        string(
            name: 'EXTRA_VARS',
            defaultValue: '',
            description: 'Extra variables to pass to Ansible (key=value format)'
        )
        booleanParam(
            name: 'DRY_RUN',
            defaultValue: false,
            description: 'Run in check mode (no changes applied)'
        )
    }

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

        stage('Validate') {
            steps {
                sh 'ansible --version'
                sh "ansible-playbook --syntax-check -i ${INVENTORY} ${params.PLAYBOOK}"
            }
        }

        stage('Lint') {
            steps {
                sh "ansible-lint ${params.PLAYBOOK} || true"
            }
        }

        stage('Run Playbook') {
            steps {
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
                        def ansibleCmd = [
                            "ansible-playbook",
                            "-i ${INVENTORY}",
                            "${params.PLAYBOOK}",
                            "--user=${SSH_USER}",
                            "--private-key=${SSH_KEY_FILE}",
                            "--vault-password-file=<(echo \$VAULT_PASSWORD)"
                        ]

                        if (params.DRY_RUN) {
                            ansibleCmd << '--check --diff'
                        }

                        if (params.EXTRA_VARS?.trim()) {
                            ansibleCmd << "--extra-vars \"${params.EXTRA_VARS}\""
                        }

                        sh "bash -c '${ansibleCmd.join(' ')}'"
                    }
                }
            }
        }
    }

    post {
        always {
            // Archive any generated logs or reports
            archiveArtifacts artifacts: 'logs/**/*.log', allowEmptyArchive: true
            cleanWs()
        }
        success {
            echo "Playbook ${params.PLAYBOOK} completed successfully on ${params.ENVIRONMENT}."
            // Uncomment to send Slack notifications:
            // slackSend channel: '#deployments', color: 'good',
            //     message: "✅ Ansible: ${params.PLAYBOOK} on *${params.ENVIRONMENT}* succeeded."
        }
        failure {
            echo "Playbook ${params.PLAYBOOK} FAILED on ${params.ENVIRONMENT}."
            // Uncomment to send Slack notifications:
            // slackSend channel: '#deployments', color: 'danger',
            //     message: "❌ Ansible: ${params.PLAYBOOK} on *${params.ENVIRONMENT}* failed."
        }
    }
}
