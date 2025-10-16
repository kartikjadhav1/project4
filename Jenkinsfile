pipeline{
    agent any


    parameters{
        choice(
            name:'Action',
            choices:['apply','destroy'],
            description:'choose what you want to do'
        )
    }
    
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
        stage('terraform execute action'){
            steps{
                script{
                    if (params.Action == 'apply'){
                        sh 'terraform apply -auto-approve'
                    }else
                        sh 'terraform destroy -auto-approve'
                }
            }
        }
        
    }
}