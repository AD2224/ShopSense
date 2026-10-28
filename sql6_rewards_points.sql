USE sentimentdb;

-- ShopSense Rewards Points and Checkout Discounts migration.
-- Run this file ONCE against your existing v5 database.
-- The Flask app also checks/adds these columns at startup, so this file is optional.

ALTER TABLE users ADD COLUMN reward_points INT NOT NULL DEFAULT 0;
ALTER TABLE purchase_history ADD COLUMN discount_amount DECIMAL(10,2) NOT NULL DEFAULT 0;
ALTER TABLE purchase_history ADD COLUMN points_earned INT NOT NULL DEFAULT 0;
ALTER TABLE purchase_history ADD COLUMN points_redeemed INT NOT NULL DEFAULT 0;
ALTER TABLE reviews ADD COLUMN points_awarded INT NOT NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS reward_transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    points_change INT NOT NULL,
    reason VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_reward_transactions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_rewards_user_date (user_id, created_at)
);
