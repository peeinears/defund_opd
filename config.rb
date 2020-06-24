# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# URLs generated by link_to should be relative
set :relative_links, true

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

configure :build do
  activate :minify_css
  activate :gzip
end

configure :development do
  set :host, "http://lvh.me:4567"
  activate :livereload
end

# Directories like /subscribe/index.html should render as /subscribe on the site
activate :directory_indexes

# Asset caching (https://middlemanapp.com/advanced/improving-cacheability/)
activate :asset_hash

app.data.districts.each do |district|
  proxy "district#{district.number}/index.html", "/district.html", locals: { district: district }, ignore: true
  proxy "district#{district.number}/call/index.html", "/call.html", locals: { district: district }, ignore: true
end

helpers do
  def mailto(to, cc: nil, subject: nil, body: nil)
    URI::MailTo.build(
      to: to,
      headers: {
        'cc' => cc,
        'subject' => CGI.escape(subject),
        'body' => CGI.escape(body),
      }.compact.to_a
    ).to_s
  end

  def at_large_councilmember
    Struct.new(:name, :email, :phone).new(
      'Rebecca Kaplan',
      '510-238-7008',
      'rkaplan@oakland.gov'
    )
  end

  def email_subject
    "Defund OPD"
  end

  def email_body
    <<-EOSTR
[Your Address
City, State, Zip
Date]

Dear Council Member [Last Name]

My name is _______ and I live in District ___________. I call on you to meaningfully reduce the Oakland Police Department’s funding during this month’s budget adjustments and prioritize saving and expanding essential investments in our communities most impacted by police violence.

Reforms of policing practices alone are not enough. The scandal-plagued police department consumes 44% of Oakland’s General Fund, more than any other major city in the nation. This does nothing but further harm low-income communities of color. I agree with Council Member Fortunado Bas: we need to de-invest in OPD and further invest in the “fundamental needs of every community member”. We must meet this moment and listen to the millions across our country who are demanding action as we mourn the deaths of George Floyd, Breonna Taylor, Erik Salgado, and countless other victims of police murder in the East Bay and around the country. 

Especially during a pandemic -- when crime is down, city revenue has fallen, and Black and Brown people are especially vulnerable to underfunding of social and health services -- there is no reason to continue granting OPD money for militarized equipment and unchecked overtime pay. We demand accountability from City Hall and an end to the inequitable persecution of Black people and systemic disregard of Black lives. With all speed, you must: 

Defund our police. By reducing our police force to 678 officers, the number required by Measure Z (678), we could unfreeze hiring in other sectors, restore recreation, arts, and vocational training programs which are currently slated to be cut. We must further end the abuse of our city’s coffers by placing strict limits, enforced by legislation, on both OPD overtime pay and the use of general fund money to pay out settlements resulting from police misconduct.
Demilitarize our police. End the use of tear gas and rubber bullets, ban chokeholds and other forms of excessive force, and eliminate racial profiling by law enforcement.
Protect our children. Oakland must remove all police officers from Oakland Unified School District schools and comply with the demands of the Black Organizing Project. The school police budget should be reinvested into supports for the whole child and students with disabilities. 
Invest in Community. Going forward, Oakland must divest from police and further invest in restorative justice practices, affordable housing, public education, and frontline mental health care for our communities. 
Implement the Civilian Police Commission. Work with the Anti-Police Terror Project and Coalition for Police Accountability to fully implement Measure LL and to establish an independent Police Commission, ensuring improved oversight of OPD.
Donate all OPOA campaign contributions. Give all donations you have received from the Oakland Police Officers Association Political Action Committee to bail funds, mutual aid organizations, and/or local nonprofits defending Black lives and pledge to not take any more money from police unions. 

Black Lives Matter.
 
Sincerely,

[Name]
    EOSTR
  end
end

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
