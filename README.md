# <img src="public/bridge.svg" style="height: 30px;"> Hashi - ACLC Web Payment App

## Introduction
Welcome to the Hashi development guide, the unofficial web payment app of AMA Computer Learning Center Iriga (ACLC). This README provides instructions for setting up Laravel Jetstream with Vue, configuring the project for VSCode environments, and tips for debugging and development, as well as integrating Paymongo and Pusher for payment processing and real-time interactions.

## Prerequisites
Before starting, ensure you have:
- [Git](https://git-scm.com/)
- [XAMPP](https://www.apachefriends.org/download.html)
- [PHP](https://www.php.net/)
- [Composer](https://getcomposer.org/)
- [Node.js and npm](https://nodejs.org/)
- VSCode (with PHP, Laravel and Vue extensions) for setup or PHPStorm
- A web server (like Apache or Nginx) or Laravel's built-in server for testing

## Setting Up the Project
1. **Clone the Repository**:
    - Use Git to clone the Hashi project:
      ```
      git clone https://github.com/ronhedwigzape/hashi
      ```

2. **Open the Project**:
    - In VSCode/PHPStorm, open the cloned project directory.

3. **Install Composer Dependencies**:
    - In the terminal, run:
      ```
      composer install
      ```

4. **Install Node.js Dependencies**:
    - Install the necessary Node.js dependencies:
      ```
      npm install
      ```

5. **Generate App Key**:
    - If there's no app key yet, generate one:
      ```
      php artisan key:generate
      ```

6. **Set Up Paymongo API Keys**:
    - Sign up for a [Paymongo](https://www.paymongo.com/) account and obtain your API keys from the Paymongo dashboard.
    - Add your Paymongo API keys to your `.env` file:
      ```env
      PAYMONGO_PUBLIC_KEY=your_public_key
      PAYMONGO_SECRET_KEY=your_secret_key
      ```

7. **Set Up Pusher API Keys**:
    - Create a [Pusher](https://pusher.com/) account and create an application to get your Pusher app credentials.
    - Add your Pusher API keys to your `.env` file:
      ```env
      PUSHER_APP_ID=your_app_id
      PUSHER_APP_KEY=your_app_key
      PUSHER_APP_SECRET=your_app_secret
      PUSHER_APP_CLUSTER=your_app_cluster
      ```

8. **Run the App**:
    - Start the Laravel server by running the following command in a terminal:
      ```
      php artisan serve
      ```
    - In another terminal, compile your assets and watch for changes with:
      ```
      npm run dev
      ```

## Debugging and Development
1. **Debugging Tools**:
    - Use VSCode/PHPStorm for debugging with breakpoints.

2. **Using Laravel Telescope**:
    - Laravel Telescope provides insight into the requests coming into your application, exceptions, log entries, database queries, queued jobs, mail, notifications, cache operations, scheduled tasks, variable dumps and more. Install it using composer:
      ```
      composer require laravel/telescope
      ```

3. **Checking Logs**:
    - Use the Laravel log in storage/logs/laravel.log or `php artisan tail` in the terminal.

4. **Troubleshooting**:
    - Refer to [Laravel documentation](https://laravel.com/docs/10.x/telescope) or the project's issue tracker for help.

## Additional Steps for VSCode
1. **Install Extensions**:
    - Install the PHP, Laravel and Vue extensions from the VSCode marketplace.

2. **Open and Run the Project**:
    - Open the project folder in VSCode.
    - Use the integrated terminal to run `composer install` and `npm run dev`.
    - Launch the app with `php artisan serve`.

3. **Debugging in VSCode**:
    - Leverage the built-in debugging tools in VSCode.
    - Set breakpoints and inspect variables during runtime.

4. **Viewing Output and Logs**:
    - Monitor the output and logs in the VSCode console.

Following these steps should get you set up for VSCode/PHPStorm development environments for the Hashi app, including the integration of Paymongo and Pusher for handling payments and real-time features.
