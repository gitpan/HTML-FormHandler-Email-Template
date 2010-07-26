package HTML::FormHandler::Email::Template;

use Carp;
use Moose;
use Template;

extends 'HTML::FormHandler::Email';

our $VERSION = '0.01002';

augment 'build_body' => sub {
    my $self = shift;
    my $vars = $self->tt_vars;
    eval { $self->template; };
    croak 'No template specified in form class' if $@;
    my $fields = [];
    foreach (keys %$vars) {
        push @$fields, $vars->{$_};
    }
    my $args = {
        'field' => $vars,
        'fields' => $fields,
    };
    my $config = {
        ABSOLUTE => 1,
        RELATIVE => 1,        
    };
    my $tt = Template->new($config);
    my $out = '';
    $tt->process($self->template, $args, \$out) or croak $tt->error();
    return $out;
};

__PACKAGE__->meta->make_immutable;

use namespace::autoclean;

1;

=head1 NAME

HTML::FormHandler::Email::Template - Easily send templated emails from your HTML::FormHandler forms with Template Toolkit

=head1 SYNOPSIS

In your form class:

    package MyApp::Form::Contact;

    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Email::Template';

    # see docs for HTML::FormHandler::Email
    has 'to' => ( is => 'rw', default => 'aesop@unicornmob.com' );
    has 'from' => ( is => 'rw', default => 'noreply@unicornmob.com' );
    has 'subject' => ( is => 'rw', default => 'Get on Star Trek: TNG and face Picard the bill collector' );

    has 'template' => ( is => 'rw', default => '/path/to/template.tt2 OR filehandle OR globref' );

    <.... rest of form ....>

In your template (Template Toolkit):

    [% field.phone.name %]: [% field.phone.value %]
    [% field.address.name %]: [% field.address.value %]

    [% FOREACH i IN fields %]
    [% i.name %]: [% i.value %]
    [% END %]

In your Catalyst controller:

    my $form = MyApp::Form::Contact->new;
    return unless $form->process( params => $c->req->parameters );

=head1 ATTRIBUTES

Set this in your form class:

template - Can be absolute path or relative path (relative to the forms location), filehandle or glob ref, required.

See L<HTML::FormHandler::Email> for more optional attributes to specify such as parameters for SMTP.

=head1 SUBCLASS IT OR MAKE IT A ROLE

As with L<HTML::FormHandler::Email>, it's a good idea to create a seperate class or role with the required attributes specified (to, from, template, etc.) and then apply it in your form classes. 

=head1 SEE ALSO

L<HTML::FormHandler::Email>

L<Template>

L<HTML::FormHandler::Manual>

=head1 AUTHOR

aesop E<lt>aesop@unicornmob.comE<gt>

Big thanks to gshank and all the HTML::FormHandler contributers for writing such awesome modules.

=head1 COPYRIGHT                                                                                                                                     

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
