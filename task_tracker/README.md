This project presented quite a challenge. The most conscious decision decision I made
was surrounding where I choose to log the user id. I was having trouble accessing that
information from the form page, because I wasn't sending it. I solved this by
having the user id set in the task controller's creating, and send a default value
from the form itself so that the empty value can be validated. The new value
also gets validated, but later as we update it.

Another decision that was made was to have the assigned to user be a string rather than the id
of another user. This was chosen for two reasons; one, for it to be the id of another user,
they would either have to guess that user's name or get a list of users provided to them,
which would be very insecure for a system with no passwords.
