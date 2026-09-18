\# Credit Card Payment System



Full-stack Credit Card Payment System developed using React, Django REST Framework, FastAPI and MySQL.



\## Setup Instructions



\### Prerequisites



\- Python 3.x

\- MySQL 8.4

\- Node.js and npm

\- Docker Desktop

\- Git



\### Django Backend



```bash

cd django\_backend

pip install -r requirements.txt

python manage.py migrate

python manage.py runserver



\## Database Schema



Database: `credit\_card\_payment\_db`



\### Users - `auth\_user`



Stores user authentication information.



Important fields:



\- `id`

\- `username`

\- `email`

\- `password`

\- `is\_staff`

\- `is\_superuser`



\### Cards - `cards\_card`



Stores secure card information.



Important fields:



\- `id`

\- `user\_id`

\- `card\_holder\_name`

\- `card\_type`

\- `masked\_card\_number`

\- `last\_four`

\- `expiry\_month`

\- `expiry\_year`



Full card numbers are not persisted and CVV is not stored.



\### Payments / Transactions - `payments`



Important fields:



\- `id`

\- `user\_id`

\- `card\_id`

\- `amount`

\- `status`

\- `created\_at`

\- `updated\_at`



Payment statuses:



\- `PENDING`

\- `SUCCESS`

\- `FAILED`



\### Admin Logs - `admin\_logs\_adminlog`



Stores administrative/audit activity.



\### Relationships



\- User → Cards

\- User → Payments

\- Card → Payments

