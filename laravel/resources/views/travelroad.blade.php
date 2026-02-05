<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>@yield('title', 'My Travel Bucket List')</title>
</head>
<body>

    <h1>My Travel Bucket List 2.1</h1>
        	<p><a href="{{ route('places.wished') }}">Deseados</a></p>
        	<p><a href="{{ route('places.visited') }}">Visitados</a></p>

    @yield('content') 

    <hr>
    🌟 Powered by <strong>Laravel</strong>
</body>
</html>
