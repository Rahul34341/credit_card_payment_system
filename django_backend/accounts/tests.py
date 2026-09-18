from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase


class AuthenticationTests(APITestCase):

    def setUp(self):
        self.user = User.objects.create_user(
            username="testuser",
            email="test@example.com",
            password="TestPassword123"
        )

    # 1. Test user registration
    def test_register_user(self):
        data = {
            "username": "newuser",
            "email": "new@example.com",
            "password": "NewPassword123"
        }

        response = self.client.post(
            "/api/auth/register/",
            data,
            format="json"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_201_CREATED
        )

        self.assertTrue(
            User.objects.filter(username="newuser").exists()
        )

    # 2. Test password is hashed
    def test_password_is_hashed(self):
        user = User.objects.create_user(
            username="secureuser",
            email="secure@example.com",
            password="SecurePassword123"
        )

        # Password must not be stored as plain text
        self.assertNotEqual(
            user.password,
            "SecurePassword123"
        )

        # Django should still be able to verify it
        self.assertTrue(
            user.check_password("SecurePassword123")
        )

    # 3. Test successful JWT login
    def test_login_user(self):
        data = {
            "username": "testuser",
            "password": "TestPassword123"
        }

        response = self.client.post(
            "/api/auth/login/",
            data,
            format="json"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_200_OK
        )

        self.assertIn("access", response.data)
        self.assertIn("refresh", response.data)

    # 4. Test login with incorrect password
    def test_invalid_login(self):
        response = self.client.post(
            "/api/auth/login/",
            {
                "username": "testuser",
                "password": "wrongpassword"
            },
            format="json"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_401_UNAUTHORIZED
        )

    # 5. Protected profile must reject unauthenticated users
    def test_profile_requires_authentication(self):
        response = self.client.get(
            "/api/auth/me/"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_401_UNAUTHORIZED
        )

    # 6. Authenticated user can access profile
    def test_authenticated_profile(self):
        self.client.force_authenticate(
            user=self.user
        )

        response = self.client.get(
            "/api/auth/me/"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_200_OK
        )

        self.assertEqual(
            response.data["username"],
            "testuser"
        )