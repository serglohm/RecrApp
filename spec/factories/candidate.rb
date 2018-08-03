FactoryBot.define do
  factory :cool_candidate do
    name 'Candidate Candidatov'
    country 'Estonia'
    city 'Tallinn'
    skype 'testov_skype'
    email 'testov_email'
    phone '37255555555'
    linked_in 'https://www.linkedin.com/in/testov_li/'
    github 'https://github/testov_li/'
    spoken_languages 'English B2'
    description 'Experience in the analysis of customer business requirements'
    education 'Tsiolkovsky Russian State Technological University, Moscow'
    experience 'Java EE: Spring Framework, Hibernate ORM, JUnit, GWT, JMS, Gradle, Tomcat, Android'
    expected_salary 'Currently 2000 eur net, min 2800 eur net'
    marital_status 'married'
    availability '1 month'
    user_id 1
    source_id 1
    status 1
  end
end
