ADMIN_EMAILS = ["ericzou@eqlink.com", "christopher.s.wong@gmail.com", "emily.yee@gmail.com"]
ROLES = {
  :owner => "owner", 
  :editor => "editor", 
  :viewer => "viewer" 
}

if Rails.env.production?
  YETI_URL = "http://www.pickledprojects.com"
else
  YETI_URL = "http://localhost:3001"
end