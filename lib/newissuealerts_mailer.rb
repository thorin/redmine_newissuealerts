require "mailer"

class NewissuealertsMailer < Mailer
  def newissuealert( email, issue, newissuealert)
    redmine_headers 'Project' => issue.project.identifier,
                    'Issue-Id' => issue.id,
                    'Issue-Author' => issue.author.login
    redmine_headers 'Issue-Assignee' => issue.assigned_to.login if issue.assigned_to
    message_id issue
    @author = issue.author
    @issue = issue
    @issue_url = url_for(:controller => 'issues', :action => 'show', :id => issue)
    @newissuealert = newissuealert
    #set_language_if_valid user.language
    headers 'X-Priority' => '1', 'Importance' => 'High', 'X-MSMail-Priority' => 'High' if newissuealert.priority
    subject = "[#{issue.project.name} - #{issue.tracker.name} ##{issue.id}] (#{issue.status.name}) #{issue.subject}"
    if newissuealert.subject?
      subject = render :inline => newissuealert.subject, :locals => { :issue => @issue, :issue_url => @issue_url }
    end
    mail(:to => email,
      :subject => subject)
  end
end
