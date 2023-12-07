# Function for hash password used in data migration
import bcrypt

def hash_password(password, cost=12):
    """
    Hash a password for storing.

    :param password: The password to be hashed.
    :param cost: The cost factor for bcrypt, representing computational complexity.
                 Adjust according to your system's capabilities and security requirements.
    :return: A hashed password in string format.
    """
    password_bytes = password.encode('utf-8')
    salt = bcrypt.gensalt(rounds=cost)
    hashed_password = bcrypt.hashpw(password_bytes, salt)

    return hashed_password.decode('utf-8')

# Example usage
plain_password = "my_secure_password"
hashed = hash_password(plain_password)
print("Hashed Password:", hashed)