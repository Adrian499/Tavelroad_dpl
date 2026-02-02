@extends('layouts.app')

@section('title', 'Home')

@section('content')
<p>
    <a href="{{ route('places.wished') }}">Places I'd Like to Visit</a>
</p>

<p>
    <a href="{{ route('places.visited') }}">Places I've Already Been To</a>
</p>
@endsection
