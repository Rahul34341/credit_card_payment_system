from datetime import date

from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase

from .models import Card


class CardTests(APITestCase):

    def setUp(self):
        self.user = User.objects.create_user(
            username="carduser",
            email="carduser@example.com",
            password="TestPassword123"
        )

        # Authenticate the test client
        self.client.force_authenticate(
            user=self.user
        )

        self.cards_url = "/api/cards/"

    # 1. Test adding a valid card
    def test_add_card(self):
        data = {
            "card_holder_name": "Test User",
            "card_type": "CREDIT",
            "card_number": "4111111111111111",
            "expiry_month": 12,
            "expiry_year": date.today().year + 2,
        }

        response = self.client.post(
            self.cards_url,
            data,
            format="json"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_201_CREATED
        )

        card = Card.objects.get(
            user=self.user
        )

        self.assertEqual(
            card.last_four,
            "1111"
        )

        self.assertEqual(
            card.masked_card_number,
            "************1111"
        )

    # 2. Test full card number and CVV are not returned
    def test_full_card_number_not_returned(self):
        full_card_number = "4111111111111111"

        response = self.client.post(
            self.cards_url,
            {
                "card_holder_name": "Test User",
                "card_type": "CREDIT",
                "card_number": full_card_number,
                "expiry_month": 12,
                "expiry_year": date.today().year + 2,
            },
            format="json"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_201_CREATED
        )

        self.assertNotIn(
            "card_number",
            response.data
        )

        self.assertNotIn(
            "cvv",
            response.data
        )

    # 3. Test full card number is not stored in database
    def test_full_card_number_not_stored(self):
        full_card_number = "4111111111111111"

        response = self.client.post(
            self.cards_url,
            {
                "card_holder_name": "Test User",
                "card_type": "CREDIT",
                "card_number": full_card_number,
                "expiry_month": 12,
                "expiry_year": date.today().year + 2,
            },
            format="json"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_201_CREATED
        )

        card = Card.objects.get(
            user=self.user
        )

        self.assertEqual(
            card.last_four,
            "1111"
        )

        self.assertNotEqual(
            card.masked_card_number,
            full_card_number
        )

        self.assertEqual(
            card.masked_card_number,
            "************1111"
        )

    # 4. Test authenticated user can list own cards
    def test_list_cards(self):
        Card.objects.create(
            user=self.user,
            card_holder_name="Test User",
            card_type="CREDIT",
            masked_card_number="************1111",
            last_four="1111",
            expiry_month=12,
            expiry_year=date.today().year + 2,
        )

        response = self.client.get(
            self.cards_url
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_200_OK
        )

        self.assertEqual(
            len(response.data),
            1
        )

    # 5. Test unauthenticated user cannot view cards
    def test_cards_require_authentication(self):
        # Remove authentication
        self.client.force_authenticate(
            user=None
        )

        response = self.client.get(
            self.cards_url
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_401_UNAUTHORIZED
        )

    # 6. Test deleting own card
    def test_delete_card(self):
        card = Card.objects.create(
            user=self.user,
            card_holder_name="Test User",
            card_type="CREDIT",
            masked_card_number="************1111",
            last_four="1111",
            expiry_month=12,
            expiry_year=date.today().year + 2,
        )

        response = self.client.delete(
            f"/api/cards/{card.id}/"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_204_NO_CONTENT
        )

        self.assertFalse(
            Card.objects.filter(
                id=card.id
            ).exists()
        )

    # 7. Test user cannot delete another user's card
    def test_user_cannot_delete_another_users_card(self):
        another_user = User.objects.create_user(
            username="otheruser",
            email="other@example.com",
            password="OtherPassword123"
        )

        card = Card.objects.create(
            user=another_user,
            card_holder_name="Other User",
            card_type="DEBIT",
            masked_card_number="************2222",
            last_four="2222",
            expiry_month=12,
            expiry_year=date.today().year + 2,
        )

        response = self.client.delete(
            f"/api/cards/{card.id}/"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_404_NOT_FOUND
        )

        # Confirm the other user's card was not deleted
        self.assertTrue(
            Card.objects.filter(
                id=card.id
            ).exists()
        )