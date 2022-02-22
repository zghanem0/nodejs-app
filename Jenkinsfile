//def name      = "main"
def git_branch      = "master"
def namespace       = "dev"
def repo            = ""
def gitUrl          = "git@github.com:pro-ghanem/nodejs-app.git"
def serviceName     = "simple-app"
//def registryId      = 604159183131
def awsRegion       = "us-east-1"
def ecrUrl          = "324131407134.dkr.ecr.us-east-1.amazonaws.com"
def imageTag        = "${ecrUrl}/${serviceName}:${namespace}_${BUILD_NUMBER}"

//def awsProfile      = "default"
def k8sContext      = "arn:aws:eks:us-east-1:*****:cluster/Prod-cluster"
def awsCredsId      = "ecr-credentials"
def helmDir         = ""
def gitCred         = ""


node {
  deleteDir()
  try {
   // notifyBuild('STARTED')




    stage ("Checkout"){
      checkout([$class: 'GitSCM', branches: [[name: "${git_branch}"]], extensions: [], userRemoteConfigs: [[credentialsId: "${gitCred}" , url: "${gitUrl}"]]])    
    }


// stage('build/combile code ')

// { sh label: '', script: ''' npm install '''}


    stage ('Build Docker Image'){
      sh "docker build -t ${imageTag} ."
    }

    stage('login to ecr'){

        sh "aws ecr get-login-password --region ${awsRegion} | docker login --username AWS --password-stdin ${ecrUrl}"
    }

     stage('Push Docker Image To ECR'){
         sh "docker push ${imageTag} "
     }


    // stage ('tag Image With Commit ID '){
    //   sh "docker tag ${imageTag} ${serviceName}:${namespace}_${BUILD_NUMBER}"
    // }

 //   stage ('login to ecr '){   >>> NO NEED FOR LOGIN TO ECR BECAUSE WE ALLREADY PUSSING USING ECR CERDENTIALS
//      sh "aws ecr get-login --registry-ids ${registryId} --region ${awsRegion} --no-include-email"
//sh "aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin ${ecr}"
//    }

//    stage ('Swtich context '){
//      sh "export AWS_DEFAULT_PROFILE=${awsProfile}"
//      sh "kubectl config use-context ${k8sContext}"
//    }

    // stage('Push Docker Image With Commit ID To ECR'){
    //   docker.withRegistry("https://${ecrUrl}/${serviceName}", "ecr:${awsRegion}:${awsCredsId}") {
    //   docker.image("${serviceName}:${namespace}_${BUILD_NUMBER}").push("${namespace}_${BUILD_NUMBER}")
    //   }

    // }


    stage ("Deploy ${serviceName} to ${namespace} Enviroment"){
      sh ("kubectl -n ${namespace} set image deployment/${serviceName} ${serviceName}=${ecrUrl}/${serviceName}:${namespace}_${BUILD_NUMBER}")
      sh("kubectl -n ${namespace} rollout status deploy/${serviceName}")
      }
      


//  stage('Remove local images') {
//     // remove docker images
//     sh("docker rmi -f ${serviceName}:${namespace}_${BUILD_NUMBER} || :")
//     sh("docker rmi -f ${serviceName}:${namespace}_${BUILD_NUMBER} || :")
//     sh("docker rmi -f ${ecrUrl}/${serviceName}:${namespace}_${BUILD_NUMBER} || :")
//       }


  stage ('cleanup'){
  //cleanWs()
 }
}
catch (e) {
    // If there was an exception thrown, the build failed
    currentBuild.result = "FAILED"
    throw e
  } finally {
    // Success or failure, always send notifications
   // notifyBuild(currentBuild.result)
  }
  }
