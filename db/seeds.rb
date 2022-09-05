Event.delete_all
User.delete_all

e1 = Event.create(:name => "Grace Potter & The Nocturnals @ The Capitol Theatre, Sat, Feb 23, 2013", :artist => "Grace Potter & The Nocturnals", :event_date => "Sat, Feb 23, 2013", :venue => "The Capitol Theatre", :location => "149 Westchester AvenuePort Chester, NY, 10573", :tickets => "http://www.ticketfly.com/event/194169-grace-potter-nocturnals-port-chester/", :link => "http://www.ticketfly.com/event/194169-grace-potter-nocturnals-port-chester/")
e2 = Event.create(:name => "Coheed and Cambria @ Radio City Music Hall, Mar16, 2013 Saturday @ 7:00PM EDT", :artist => "Coheed and Cambria", :event_date => "Mar 16, 2013 Saturday @ 7:00PM EDT", :venue => "Radio City Music Hall", :location => "New York, NY", :tickets => "http://www.livenation.com/events/182682/mar-16-2013/coheed-and-cambria?ui=event-row", :link => "http://www.livenation.com/events/182682/mar-16-2013/coheed-and-cambria?ui=event-row")
e3 = Event.create(:name => "The Postal Service @ Barclays Center, Fri, Jun 14, 2013 08:00 PM", :artist => "The Postal Service", :event_date => "Fri, Jun 14, 2013 08:00 PM", :venue => "Barclays Center,", :location => "Brooklyn, NY", :tickets => "http://www.ticketmaster.com/event/00004A3FE83FDA4C?artistid=862522&majorcatid=10001&minorcatid=60", :link => "http://www.ticketmaster.com/event/00004A3FE83FDA4C?artistid=862522&majorcatid=10001&minorcatid=60")

# USERS
u1 = User.create(:name => "marc", :password => "1", :password_confirmation => "1", :email => "whitperson@yahoo.com")
u2 = User.create(:name => "whit", :password => "1", :password_confirmation => "1", :email => "whitperson@gmail.com")
u3 = User.create(:name => "dude", :password => "1", :password_confirmation => "1", :email => "whitperson@livemusicblog.com")

# USERS EVENTS
u1.events = [e1, e2, e3]


