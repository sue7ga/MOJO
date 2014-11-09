package LoginTest::Root;

use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub index{
  my $self = shift;
  $self->render(template => 'root/index');
}

sub register{
  my $self = shift;
  $self->render(template => 'root/register');
}

sub mypage{
 my $self = shift;
 unless($self->session('user')){
   $self->redirect_to($self->uri_for(action => 'login'));
 }
 $self->render(template => 'root/mypage');
}

sub login{
 my $self = shift;
 my $user = $self->param('user') || '';
 my $pass = $self->param('pass') || '';

 $self->app->log->info('login check');

 if($self->session('user')){
   return 1;
 }

 $self->stash->{auth_failed} = 0;
 if($user || $pass){
   $self->app->log->info('pass check');
   if($user eq "test" && $pass eq "test"){
    $self->session(user => $user);
    return 1;
   }
   $self->stash->{auth_failed} = 1;
 }
 
 $self->render(template => 'root/auth');
 return undef;

}

sub logout{
  my $self = shift;
  $self->session(expires => 1);
  $self->redirect_to('index');
}

1;
