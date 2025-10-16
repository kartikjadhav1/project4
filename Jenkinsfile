pipeline{
    agent any
    
    stages{
        stage('git checkout'){
            steps{
                git branch: 'network', url: 'https://github.com/kartikjadhav1/project4.git'
            }
        }
        stage('terraform init'){
            steps{
                sh 'terraform init'
            }
        }
        stage('terraform plan'){
            steps{
                sh 'terraform plan'
            }
        }
        stage('terraform apply'){
            steps{
                sh 'terraform apply -auto-approve'
            }
        }
    }
}