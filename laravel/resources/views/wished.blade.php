@extends('layouts.app')

@section('title', 'Places to Visit')

@section('content')
<h2>Places I'd Like to Visit</h2>
<ul>
    @foreach($wished as $place)
        <li>{{ $place }}</li>
    @endforeach
</ul>

<p>
    <a href="{{ route('places.index') }}"> <-- Back home</a>
</p>
@endsection
