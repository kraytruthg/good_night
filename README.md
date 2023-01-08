## Spec:
1. Clock In operation, and return all clocked-in times, ordered by created time. 
2. Users can follow and unfollow other users. 
3. See the sleep records over the past week for their friends, ordered by the length of their sleep. 

## Usage:

Generate demo data via:
```
bundle exec rake db:seed
```



## API Routes

```
Verb   URI Pattern                                         Controller#Action
POST   /v1/users/:user_id/sleep(.:format)                  v1/users#sleep {:format=>"json"}
POST   /v1/users/:user_id/wake_up(.:format)                v1/users#wake_up {:format=>"json"}
GET    /v1/users/:user_id/sleeps(.:format)                 v1/sleeps#index {:format=>"json"}
GET    /v1/users/:user_id/sleeps/by_friends(.:format)      v1/sleeps#by_friends {:format=>"json"}
POST   /v1/users/:user_id/follows(.:format)                v1/follows#create {:format=>"json"}
DELETE /v1/users/:user_id/follows/:id(.:format)            v1/follows#destroy {:format=>"json"}
