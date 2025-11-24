# Laravel Buku Bisnis API Documentation

API untuk aplikasi pencatatan keuangan bisnis (Business Book Application) yang dibangun dengan Laravel dan menggunakan Laravel Sanctum untuk autentikasi.

## 📋 Daftar Isi

- [Informasi Umum](#informasi-umum)
- [Autentikasi](#autentikasi)
- [Endpoints](#endpoints)
  - [Authentication](#authentication)
  - [Accounts](#accounts)
  - [Categories](#categories)
  - [Transactions](#transactions)
- [Error Handling](#error-handling)
- [Postman Collection](#postman-collection)

## 🔧 Informasi Umum

**Base URL:** `http://localhost:8000/api` (untuk development)

**Format Response:** JSON

**Autentikasi:** Bearer Token (Laravel Sanctum)

## 🔐 Autentikasi

Sebagian besar endpoint memerlukan autentikasi menggunakan Bearer token. Setelah login, gunakan token yang diterima di header:

```
Authorization: Bearer {your-token-here}
```

## 📡 Endpoints

### Authentication

#### 1. Register
Mendaftarkan user baru.

**Endpoint:** `POST /api/auth/register`

**Request Body:**
```json
{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123",
    "password_confirmation": "password123"
}
```

**Response (201):**
```json
{
    "message": "User registered successfully",
    "user": {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "created_at": "2025-10-23T10:00:00.000000Z"
    }
}
```

---

#### 2. Login
Login dan mendapatkan token autentikasi.

**Endpoint:** `POST /api/auth/login`

**Request Body:**
```json
{
    "email": "john@example.com",
    "password": "password123"
}
```

**Response (200):**
```json
{
    "message": "Login successful",
    "token": "1|abcdefghijklmnopqrstuvwxyz",
    "user": {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com"
    }
}
```

---

#### 3. Get Current User
Mendapatkan informasi user yang sedang login.

**Endpoint:** `GET /api/auth/me`

**Headers:** `Authorization: Bearer {token}`

**Response (200):**
```json
{
    "user": {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "email_verified_at": null,
        "created_at": "2025-10-23T10:00:00.000000Z",
        "updated_at": "2025-10-23T10:00:00.000000Z"
    }
}
```

---

#### 4. Logout
Logout dan menghapus semua token.

**Endpoint:** `POST /api/auth/logout`

**Headers:** `Authorization: Bearer {token}`

**Response (200):**
```json
{
    "message": "Logged out successfully"
}
```

---

### Accounts

#### 1. List All Accounts
Mendapatkan semua akun user.

**Endpoint:** `GET /api/accounts`

**Headers:** `Authorization: Bearer {token}`

**Query Parameters:**
- `q` (optional): Cari berdasarkan nama akun
- `is_active` (optional): Filter berdasarkan status aktif (true/false)

**Response (200):**
```json
{
    "data": [
        {
            "id": 1,
            "user_id": 1,
            "name": "Main Cash",
            "type": "cash",
            "starting_balance": "1000000.00",
            "is_active": true,
            "created_at": "2025-10-23T10:00:00.000000Z",
            "updated_at": "2025-10-23T10:00:00.000000Z"
        }
    ],
    "meta": {
        "total": 1,
        "filters_applied": {
            "search": null,
            "is_active": null
        }
    }
}
```

---

#### 2. Create Account
Membuat akun baru.

**Endpoint:** `POST /api/accounts`

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
```json
{
    "name": "Main Cash",
    "type": "cash",
    "starting_balance": 1000000,
    "is_active": true
}
```

**Tipe Akun:**
- `cash`: Uang tunai
- `bank`: Bank
- `ewallet`: E-wallet (Gopay, OVO, dll)
- `other`: Lainnya

**Response (201):**
```json
{
    "message": "Account created successfully",
    "data": {
        "id": 1,
        "user_id": 1,
        "name": "Main Cash",
        "type": "cash",
        "starting_balance": "1000000.00",
        "is_active": true,
        "created_at": "2025-10-23T10:00:00.000000Z",
        "updated_at": "2025-10-23T10:00:00.000000Z"
    }
}
```

---

#### 3. Get Account Details
Mendapatkan detail akun tertentu.

**Endpoint:** `GET /api/accounts/{id}`

**Headers:** `Authorization: Bearer {token}`

---

#### 4. Update Account
Mengupdate informasi akun.

**Endpoint:** `PUT /api/accounts/{id}`

**Headers:** `Authorization: Bearer {token}`

**Request Body:** (semua field opsional)
```json
{
    "name": "Updated Account Name",
    "type": "bank",
    "starting_balance": 1500000,
    "is_active": true
}
```

---

#### 5. Delete Account
Menghapus akun.

**Endpoint:** `DELETE /api/accounts/{id}`

**Headers:** `Authorization: Bearer {token}`

**Response (200):**
```json
{
    "message": "Account deleted successfully"
}
```

**Note:** Tidak bisa menghapus akun yang masih memiliki transaksi.

---

### Categories

#### 1. List All Categories
Mendapatkan semua kategori.

**Endpoint:** `GET /api/categories`

**Headers:** `Authorization: Bearer {token}`

**Query Parameters:**
- `type` (optional): Filter berdasarkan tipe (income/expense)

**Response (200):**
```json
{
    "message": "Categories retrieved successfully",
    "data": [
        {
            "id": 1,
            "user_id": 1,
            "name": "Food & Dining",
            "type": "expense",
            "parent_id": null,
            "created_at": "2025-10-23T10:00:00.000000Z",
            "updated_at": "2025-10-23T10:00:00.000000Z",
            "parent": null
        }
    ]
}
```

---

#### 2. Create Category
Membuat kategori baru.

**Endpoint:** `POST /api/categories`

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
```json
{
    "name": "Food & Dining",
    "type": "expense",
    "parent_id": null
}
```

**Tipe Kategori:**
- `income`: Pendapatan
- `expense`: Pengeluaran

**Response (201):**
```json
{
    "message": "Category created successfully",
    "data": {
        "id": 1,
        "user_id": 1,
        "name": "Food & Dining",
        "type": "expense",
        "parent_id": null,
        "created_at": "2025-10-23T10:00:00.000000Z",
        "updated_at": "2025-10-23T10:00:00.000000Z",
        "parent": null
    }
}
```

---

#### 3. Get Category Details
Mendapatkan detail kategori tertentu.

**Endpoint:** `GET /api/categories/{id}`

**Headers:** `Authorization: Bearer {token}`

---

#### 4. Update Category
Mengupdate informasi kategori.

**Endpoint:** `PUT /api/categories/{id}`

**Headers:** `Authorization: Bearer {token}`

---

#### 5. Delete Category
Menghapus kategori.

**Endpoint:** `DELETE /api/categories/{id}`

**Headers:** `Authorization: Bearer {token}`

**Note:** Tidak bisa menghapus kategori yang masih memiliki transaksi atau subkategori.

---

### Transactions

#### 1. List All Transactions
Mendapatkan semua transaksi dengan pagination dan filter.

**Endpoint:** `GET /api/transactions`

**Headers:** `Authorization: Bearer {token}`

**Query Parameters:**
- `account_id` (optional): Filter berdasarkan akun
- `category_id` (optional): Filter berdasarkan kategori
- `type` (optional): Filter berdasarkan tipe (income/expense)
- `from_date` (optional): Filter dari tanggal (YYYY-MM-DD)
- `to_date` (optional): Filter sampai tanggal (YYYY-MM-DD)
- `q` (optional): Cari di note atau counterparty
- `min_amount` (optional): Filter jumlah minimum
- `max_amount` (optional): Filter jumlah maksimum
- `sort_by` (optional): Urutkan berdasarkan (date/amount/created_at)
- `sort_order` (optional): Urutan (asc/desc)
- `per_page` (optional): Jumlah per halaman (max 100)

**Response (200):**
```json
{
    "message": "Transactions retrieved successfully",
    "data": [
        {
            "id": 1,
            "user_id": 1,
            "account_id": 1,
            "category_id": 1,
            "type": "expense",
            "date": "2025-10-23",
            "amount": "150000.00",
            "note": "Lunch at restaurant",
            "counterparty": "Restaurant Name",
            "transfer_group_id": null,
            "created_at": "2025-10-23T10:00:00.000000Z",
            "updated_at": "2025-10-23T10:00:00.000000Z",
            "account": {
                "id": 1,
                "name": "Main Cash",
                "type": "cash"
            },
            "category": {
                "id": 1,
                "name": "Food & Dining",
                "type": "expense"
            }
        }
    ],
    "pagination": {
        "current_page": 1,
        "last_page": 1,
        "per_page": 15,
        "total": 1,
        "from": 1,
        "to": 1
    }
}
```

---

#### 2. Create Transaction
Membuat transaksi baru.

**Endpoint:** `POST /api/transactions`

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
```json
{
    "account_id": 1,
    "category_id": 1,
    "type": "expense",
    "date": "2025-10-23",
    "amount": 150000,
    "note": "Lunch at restaurant",
    "counterparty": "Restaurant Name"
}
```

**Response (201):**
```json
{
    "message": "Transaction created successfully",
    "data": {
        "id": 1,
        "user_id": 1,
        "account_id": 1,
        "category_id": 1,
        "type": "expense",
        "date": "2025-10-23",
        "amount": "150000.00",
        "note": "Lunch at restaurant",
        "counterparty": "Restaurant Name",
        "transfer_group_id": null,
        "created_at": "2025-10-23T10:00:00.000000Z",
        "updated_at": "2025-10-23T10:00:00.000000Z",
        "account": {...},
        "category": {...}
    }
}
```

---

#### 3. Get Transaction Details
Mendapatkan detail transaksi tertentu.

**Endpoint:** `GET /api/transactions/{id}`

**Headers:** `Authorization: Bearer {token}`

---

#### 4. Update Transaction
Mengupdate transaksi.

**Endpoint:** `PUT /api/transactions/{id}`

**Headers:** `Authorization: Bearer {token}`

**Note:** Tidak bisa mengupdate transaksi transfer melalui endpoint ini.

---

#### 5. Delete Transaction
Menghapus transaksi.

**Endpoint:** `DELETE /api/transactions/{id}`

**Headers:** `Authorization: Bearer {token}`

---

#### 6. Create Transfer
Membuat transfer antar akun.

**Endpoint:** `POST /api/transactions/transfer`

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
```json
{
    "from_account_id": 1,
    "to_account_id": 2,
    "amount": 500000,
    "date": "2025-10-23",
    "note": "Transfer from cash to bank"
}
```

**Response (201):**
```json
{
    "message": "Transfer created successfully",
    "data": {
        "transfer_group_id": "abc123-def456-...",
        "from_transaction": {...},
        "to_transaction": {...}
    }
}
```

**Note:** Transfer otomatis membuat 2 transaksi yang saling terhubung (expense dari akun asal, income ke akun tujuan).

---

#### 7. Get Transaction Statistics
Mendapatkan statistik transaksi.

**Endpoint:** `GET /api/transactions-statistics`

**Headers:** `Authorization: Bearer {token}`

**Query Parameters:**
- `from_date` (optional): Dari tanggal (YYYY-MM-DD)
- `to_date` (optional): Sampai tanggal (YYYY-MM-DD)
- `account_id` (optional): Filter berdasarkan akun
- `category_id` (optional): Filter berdasarkan kategori

**Response (200):**
```json
{
    "message": "Transaction statistics retrieved successfully",
    "data": {
        "total_income": "5000000.00",
        "total_expense": "1500000.00",
        "transaction_count": 25,
        "income_count": 10,
        "expense_count": 15,
        "net_amount": "3500000.00"
    }
}
```

---

## ⚠️ Error Handling

API menggunakan HTTP status code standar:

- **200 OK** - Request berhasil
- **201 Created** - Resource berhasil dibuat
- **400 Bad Request** - Request tidak valid
- **401 Unauthorized** - Tidak terutentikasi atau token tidak valid
- **404 Not Found** - Resource tidak ditemukan
- **422 Unprocessable Entity** - Validasi gagal
- **500 Internal Server Error** - Error server

### Contoh Error Response

```json
{
    "message": "The given data was invalid.",
    "errors": {
        "email": [
            "The email has already been taken."
        ],
        "password": [
            "The password must be at least 8 characters."
        ]
    }
}
```

---

## 📦 Postman Collection

Untuk memudahkan testing API, gunakan Postman collection yang sudah disediakan:

1. Import file `Laravel-Buku-Bisnis-API.postman_collection.json` ke Postman
2. Import file `Laravel-Buku-Bisnis-API.postman_environment.json` untuk environment variables
3. Update `base_url` di environment sesuai dengan server Anda
4. Login untuk mendapatkan token (otomatis tersimpan di environment variable)
5. Mulai testing API

### Fitur Postman Collection:
- Auto-save token setelah login
- Auto-save ID resource yang dibuat (account_id, category_id, transaction_id)
- Pre-configured request examples untuk semua endpoints
- Organized dalam folders berdasarkan resource type

---

## 🚀 Integrasi dengan Flutter

### Setup Dio (HTTP Client)

```dart
// lib/services/api_service.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://your-server-url.com/api';
  late Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));

    // Interceptor untuk menambahkan token
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        // Handle error
        return handler.next(error);
      },
    ));
  }

  // Auth methods
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      // Save token
      if (response.data['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', response.data['token']);
      }

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Account methods
  Future<List<dynamic>> getAccounts() async {
    try {
      final response = await _dio.get('/accounts');
      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }

  // Transaction methods
  Future<Map<String, dynamic>> createTransaction(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/transactions', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Add more methods as needed...
}
```

### Contoh Penggunaan di Flutter

```dart
// Login
final apiService = ApiService();
try {
  final result = await apiService.login('user@example.com', 'password123');
  print('Login success: ${result['user']['name']}');
} catch (e) {
  print('Login failed: $e');
}

// Get accounts
try {
  final accounts = await apiService.getAccounts();
  print('Total accounts: ${accounts.length}');
} catch (e) {
  print('Failed to get accounts: $e');
}

// Create transaction
try {
  final transaction = await apiService.createTransaction({
    'account_id': 1,
    'category_id': 1,
    'type': 'expense',
    'date': '2025-10-23',
    'amount': 150000,
    'note': 'Lunch',
  });
  print('Transaction created: ${transaction['data']['id']}');
} catch (e) {
  print('Failed to create transaction: $e');
}
```

---

## 📝 Notes

1. Semua tanggal menggunakan format YYYY-MM-DD
2. Semua amount menggunakan numeric (integer atau decimal)
3. Category type harus sesuai dengan transaction type
4. Transfer otomatis membuat kategori "Transfer" jika belum ada
5. Tidak bisa menghapus akun/kategori yang masih digunakan oleh transaksi
6. Token autentikasi tidak memiliki expiry time (valid hingga logout)

---

## 🔗 Links

- [Laravel Documentation](https://laravel.com/docs)
- [Laravel Sanctum](https://laravel.com/docs/sanctum)
- [Postman Documentation](https://www.postman.com/docs)
- [Dio Flutter Package](https://pub.dev/packages/dio)

---

**Last Updated:** 23 Oktober 2025
