This is my submission to CheckRecipient's code challenge. The application runs from two simple models off the back of a Postgres database with a simple UI for easy referencing. The data is as accurate as I could make it in such a short time period. Ideally testing against some fixtures would have been great. I manually counted a small cross section to make sure I was heading in the right direction.

The database schema is as simple as I could get it. I decided to create an analytics task that collects and operates on raw data and writes outputs to specified columns instead of “on the fly” to keep the load off the web server.

With the analytics task encapsulated and away from the controller logic it can be offloaded onto a worker container or even multithreaded across many worker containers to speed it up.

## Challenge refactors:
Application has the following features
- Started a new rails instance using the latest version.
- Updated the uploads rake task to use "as_json" to better format post payload. This speeds the upload process up as we don’t have to tidy up the data before we process it.
- Moved “mini” & “uploads” into a public directory. Makes sense, to me anyway.
- Updated the uploads rake task to reference new json location.

## Application Overview
- Challenge took around 6 working hours to complete.
- Upload process contains 1 read and 1 write per email with an additional write being situational.
- Rake task to import from a JSON source.
- Rake task to analyse emails in database and output insights.
- Simple UI to view and search through results.
- Migrations to construct a schema.
- Scope to pick out the “top x” used subject words.
- Scope to get all unique subject words.
- Scope to get count of emails recieved in current month.
- Comprehensive set of seeded datasets to populate the schema.

## What I would do better / liked to have done?
- If I had more time I would have used Mongoid to create a Key/Value store against the emails and recipients. I would have used Mongoid’s built in relationship management to handle the email > recipient relationship on a flat file system. This would have increased the write speeds significantly.
- I would have liked to have written some comprehensive tests to make sure the analytics is 100% accurate.
- I would have liked to implement Sidekiq or Resque to perform the analytics task away from the web threads. Ideally these would be in separate worker containers away from the main web server.
- The UI is not what I would exactly call efficient. I would have liked to spend more time on the usability and create something a bit more slicker.
- I would have liked to have had the time to create a good single view per recipient.
