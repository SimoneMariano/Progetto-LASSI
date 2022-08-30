def can?(action, subject, *extra_args)
    subject_arg = subject.is_a?(User::Decorator) ? subject.model : subject
    subject_arg = subject.is_a?(Admin::Decorator) ? subject.model : subject
    super(action, subject_arg, *extra_args)
  end
  
  def authorize!(action, subject, *extra_args)
    subject_arg = subject.is_a?(Admin::Decorator) ? subject.model : subject
    super(action, subject_arg, *extra_args)
  end