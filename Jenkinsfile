pipeline{
    agent any
    
    stages{
        stage('git checkout'){
            steps{
                git branch: 'network', url: 'https://github.com/kartikjadhav1/project4.git'
            }
        }
        stage('terraform destroy'){
            steps{
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}