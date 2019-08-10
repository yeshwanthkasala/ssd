pipeline {
    agent any 
    tools { 
        maven 'Maven' 
      
    }
stages { 
     
 stage('Preparation') { 
     steps {
// for display purposes

      // Get some code from a GitHub repository

      git 'https://github.com/raknas999/hello-world-servlet.git'

      // Get the Maven tool.
     
 // ** NOTE: This 'M3' Maven tool must be configured
 
     // **       in the global configuration.   
     }
   }

   stage('Build') {
       steps {
       // Run the maven build

      //if (isUnix()) {
         sh 'mvn -Dmaven.test.failure.ignore=true install'
      //} 
      //else {
      //   bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
       }
//}
   }
 
  stage('Results') {
      steps {
      junit '**/target/surefire-reports/TEST-*.xml'
      archiveArtifacts 'target/*.war'
      }
 }
 stage('Sonarqube') {
    environment {
        scannerHome = tool 'sonarqube'
    }
    steps {
        withSonarQubeEnv('sonarqube') {
            sh "${scannerHome}/bin/sonar-scanner"
        }
        timeout(time: 10, unit: 'MINUTES') {
            waitForQualityGate abortPipeline: true
        }
    }
}
     stage('Artifact upload') {
      steps {
     nexusArtifactUploader artifacts: [[artifactId: '\'nexus-artifact-uploader\'', classifier: '\'debug\'', file: 'hello-world-servlet-example-1.0-SNAPSHOT.war', type: 'war']], credentialsId: 'nexus', groupId: 'com.geekcap.vmturbo', nexusUrl: '18.220.30.249:8081/nexus', nexusVersion: 'nexus2', protocol: 'http', repository: 'hello-world-servlet-example', version: '1.5'
      }
 }
}
}
