<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\DB;

Route::get('/', function () {
    return view('index'); // carga index.blade.php
})->name('places.index');

Route::get('/visited', function () {
    // Trae los nombres de los lugares visitados de la tabla 'places'
    $visited = DB::table('places')->where('visited', true)->pluck('name');
    return view('visited', ['visited' => $visited]);
})->name('places.visited');

Route::get('/wished', function () {
    // Trae los nombres de los lugares por visitar de la tabla 'places'
    $wished = DB::table('places')->where('visited', false)->pluck('name');
    return view('wished', ['wished' => $wished]);
})->name('places.wished');
