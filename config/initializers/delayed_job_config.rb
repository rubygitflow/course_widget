Delayed::Worker.max_attempts = 5
Delayed::Worker.delay_jobs = !Rails.env.test?
Delayed::Worker.destroy_failed_jobs = true
Delayed::Worker.read_ahead = 10
