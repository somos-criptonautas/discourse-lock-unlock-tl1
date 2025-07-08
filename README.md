# discourse-lock-unlock-tl1

## Installation

cd /var/www/discourse/plugins
git clone https://github.com/YOUR_USERNAME/discourse-lock-unlock-tl1.git
./launcher rebuild app

text

## Usage
1. **Lock Automation**:  
   - Trigger: *User Added to Group*  
   - Field: Select target group  

2. **Unlock Automation**:  
   - Trigger: *User Removed from Group*  
   - Field: Same target group  
