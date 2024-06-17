#!/usr/bin/env bash

cd /var/www/html/laravel || exit

VIEW_PATH="/var/www/html/laravel/resources/views/userslaravel/index.blade.php"
ROUTE_PATH="/var/www/html/laravel/routes/web.php"
MODEL_NAME="UserLaravel"
CONTROLLER_NAME="UserLaravelController"

# Function pour créer le modèle
create_model() {
    echo "Création du modèle $MODEL_NAME" || exit
    php artisan make:model $MODEL_NAME
}

# Function pour créer le contrôleur
create_controller() {
    echo "Création du contrôleur $CONTROLLER_NAME" || exit
    php artisan make:controller $CONTROLLER_NAME
}

# Function pour ajouter du code au contrôleur
update_controller() {
    echo "Mise à jour du contrôleur $CONTROLLER_NAME" || exit
    cat <<EOT > app/Http/Controllers/$CONTROLLER_NAME.php

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\\$MODEL_NAME;

class $CONTROLLER_NAME extends Controller
{
    public function index()
    {
        // Récupérer tous les utilisateurs de la base de données
        \$$MODEL_NAME = $MODEL_NAME::all();

        // Passer les données à la vue
        return view('users.index', compact('$MODEL_NAME'));
    }
}
EOT
}

# Function pour créer la vue
create_view() {
    echo "Création de la vue $VIEW_PATH" || exit
    mkdir -p "$(dirname $VIEW_PATH)"
    cat <<EOT > $VIEW_PATH
<!DOCTYPE html>
<html>
<head>
    <title>Liste des utilisateurs</title>
</head>
<body>
    <h1>Liste des utilisateurs</h1>
    <ul>
        @foreach (\$users as \$user)
            <li>{{ \$user->name }} - {{ \$user->email }}</li>
        @endforeach
    </ul>
</body>
</html>
EOT
}

# Function pour mettre à jour les routes
update_routes() {
    echo "Mise à jour des routes dans $ROUTE_PATH" || exit
    cat <<EOT >> $ROUTE_PATH

use App\Http\Controllers\\$CONTROLLER_NAME;

Route::get('/users', [$CONTROLLER_NAME::class, 'index']);
EOT
}

# Exécution des functions
create_model
create_controller
update_controller
create_view
update_routes
php artisan migrate

echo "Script terminé avec succès"