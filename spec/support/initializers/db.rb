require 'data_mapper'

# If you want the logs displayed you have to do this before the call to setup
# DataMapper::Logger.new($stdout, :debug)

# An in-memory Sqlite3 connection:
DataMapper.setup(:default, 'sqlite::memory:')


# Drop and then Create record tables
DataMapper.auto_migrate!
