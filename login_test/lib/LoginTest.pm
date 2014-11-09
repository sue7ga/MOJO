package LoginTest;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->secrets(['secretword']);

  # Router
  my $r = $self->routes;
   
  $r = $r->bridge->to('root#login');

  # Normal route to controller
  $r->any('/')->to('root#index')->name('index');

  $r->get('/register')->to('root#register');

  $r->get('/mypage')->to('root#mypage');
  
  $r->get('/logout')->to('root#logout');
}

1;
