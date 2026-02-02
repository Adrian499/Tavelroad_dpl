@extends('layouts.app')

@section('title', 'Places Visited')

@section('content')
<h2>Places I've Already Been To</h2>
<ul>
    @foreach($visited as $place)
        <li>{{ $place }}</li>
    @endforeach
</ul>

<p>
    <a href="{{ route('places.index') }}"> <-- Back home</a>
</p>
@endsection
