### Setup:

1. On AWS create a EC2 t2.micro instance expose ports 80, 22
2. ssh into the instace
3. Install docker, docker-compose and git:
   - <pre><code>sudo yum install docker</pre></code>
   - <pre><code>sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null</pre></code>
   - <pre><code>sudo chmod +x /usr/local/bin/docker-compose</pre></code>
   - <pre><code>ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose</pre></code>
   - <pre><code>docker-compose --version</pre></code>
4. Clone this repository: git clone https://github.com/Tiki92/devOps.git
5. Start containsers:
   - <pre><code>cd devOps</pre></code>
   - <pre><code>docker-compose -f docker-compose.yml up --build</pre></code>
6. Create Load Balancer:
   - On AWS Load Balancing -> Load Balancers -> Create Load Balancer -> Classic Load Balancer
   - Name the balancer
   - Check Enable advanced VPC configuration
   - Select two available zones
   - Create new security group type HTTP, protocol TCP, port range 80, source 0.0.0.0/0
   - Configure Health Check Ping: Protocol HTTP, Ping Port 80, Ping Path "/", Advanced Settings default
   - Add your instance


### CodePipeline, CodeBuild, Jenkins, Ansible CI/CD
[Live website here](http://52.29.7.88/)

1. On AWS create a EC2 expose port 8080
    - Install and configure Jenkins
    - Install git
    - Install ansible
2. On AWS CloudFormation create a stack using the tamplate "devOps_stack.yml"
    - In the template change the instance keyname with your keyname for that instance
3. On CodePipeline create pipeline:
    - Create a new role or select an existing one
    - Add source stage, connect to github and select this project
    - Add build stage, Build Provider: Add Jenkins
    - Create "Provider Name", remeber it to use in the Jenkins project
    - Add the Server URL: "your Jenkins server ip"
    - Create "Project Name", remeber it to use in the Jenkins project
    - Skip Deploy stage and create pipeline
    - Go to the pipeline details, click on the top right "Edit"
    - In the section "Build" click "Edit stage" and add section
    - Create: Name, Select Provider: AWS CloudFormation, Select Region, Input Artifact: SourceArtifact, Action Mode: Create update stack, Stack Name: "the stack you created in step 2", Artifact Name: SourceArtifact, File Name: devOps_stack.yml, Capabilities: CAPABILITY_IAM, Role name: create or select a role with the right permissions
4. On your Jenkins server:
    - Go to Manage Plugins and install AWS CodePipeline, Docker Compose plugin
    - Go to the main Jenkins page and create new item, give the project the same name you created in codebuild and select free style project
    - Check "Execute concurrent builds if necessary"
    - Source Code Management: Select "AWS CodePipeline", Select your region, Category: Build, Provider: the provider you created in codebuild
    - Build Triggers: cheack "Poll SCM" and enter in the field "* * * * *"
    - Build: Select "Docker Compose", Docker Compose file: docker-compose.yml, Docker Compose Command: Start all services
    - Create another "Docker Compose", Docker Compose file: docker-compose.yml, Docker Compose Command: Stop all services
    - Create "Execute shell": add ". /var/lib/jenkins/workspace/dockerCompose/deploy.sh"
    - Post-build Actions: Select "AWS CodePipeline Publisher" and select add, leave it black
5. Copy the keypair.pem from your cloudformation instace in your jenkins instace in "/var/lib/jenkins/workspace/"
6. In the "inventory" file change the ansible_host with the ip of you cloudformation instance
7. In "deploy.sh" change the location of keypair.pem, inventory and playbook.yml with your locations
8. In the playbook.yml you can change the git repo to your forked repo