-- 데이터 삽입
ALTER TABLE drink_order ADD COLUMN order_status VARCHAR(50);
ALTER TABLE drink_order modify column id INT AUTO_INCREMENT;

INSERT INTO drink_order (id, customer_id, ordered_at, total_amount, order_status) VALUES
(null, 101, '2024-02-26', 15.99, 'completed'),
(null, 102, NULL, 10.50, 'pending'),
(null, NULL, '2024-02-25', 8.75, 'completed'),
(null, 103, '2024-02-24', 20.00, 'processing');

-- CASE 문을 사용하여 order_status 값에 따라 처리
SELECT id,
       customer_id,
       ordered_at,
       total_amount,
       order_status,
       CASE order_status
           WHEN 'completed' THEN 'Order is completed'
           WHEN 'pending' THEN 'Order is pending'
           WHEN 'processing' THEN 'Order is processing'
           ELSE 'Unknown status'
       END AS status_description
FROM drink_order;