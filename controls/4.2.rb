control "4.2" do
  title "Ensure the 'test' Database Is Not Installed (Scored)"
  desc  "The default MySQL installation comes with an unused database called test. 
  It is recommended that the test database be dropped"
  impact 0.5 #double check
  tag "severity": "medium"  #double check
  tag "cis_id": "4.2"
  tag "cis_control": ["No CIS Control", "6.1"] #don't know
  tag "cis_level": 1
  tag "audit text": "
  Execute the following SQL statement to determine if the test database is present:
    SHOW DATABASES LIKE 'test';
  The above SQL statement will return zero rows"
  tag "fix": "Execute the following SQL statement to drop the test database:
    DROP DATABASE 'test';
  Note: mysql_secure_installation performs this operation as well as other security- related activities"
  tag "Default Value": ""

  query = %(SHOW DATABASES LIKE 'test';)

  sql_session = mysql_session(attribute('user'),attribute('password'),attribute('host'),attribute('port'))
           
  database_present = sql_session.query(query).stdout.strip

  describe 'The check wether the test database is installed' do
    subject { database_present }
    it {should be_empty}
  end

end
