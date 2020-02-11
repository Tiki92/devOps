### Setup:

1. On AWS create a EC2 t2.micro instance expose ports 80, 22
2. ssh into the instace
3. Install docker, docker-compose and git:
   - <pre><code>sudo yum install docker</pre></code>
   - <pre><code>sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null</pre></code>
   - <pre><code>sudo chmod +x /usr/local/bin/docker-compose</pre></code>
   - <pre><code>ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose</pre></code>
   - <pre><code>docker-compose --version</pre></code>
4. Clone this repository: git clone -----
5. Start containsers: docker-compose -f docker-compose.yml up --build
6. Create Load Balancer:
   - On AWS Load Balancing -> Load Balancers -> Create Load Balancer -> Classic Load Balancer
   - Name the balancer
   - Check Enable advanced VPC configuration
   - Select two available zones
   - Create new security group type HTTP, protocol TCP, port range 80, source 0.0.0.0/0
   - Configure Health Check Ping: Protocol HTTP, Ping Port 80, Ping Path "/", Advanced Settings default
   - Add your instance
