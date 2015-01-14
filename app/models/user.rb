class User < ActiveRecord::Base
  validates :name, presence: true
  after_initialize -> { logger.debug 'after initialize' }
  # 의문점: 람다나 proc을 파라미터로 전달을 하러면 & 를 꼭 붙여야 된다고 배웠다. 하지만 어떻게 안붙이고도 호출이 되는지....?
  # 재밌는점은 붙이던 안붙이던 다 된다는거다...하지만 내 custom method는 안된다는거....
  # core 에서 어떤 처리를 한것인가...
  before_validation :call_this_before, &-> { logger.debug 'before validate 2222222222222222222222' }
  after_validation &-> { logger.debug 'after validate' }
  around_save do |activity, block|
    logger.debug "before around save"
    block.call
    logger.debug "after around save"
  end
  before_save do
    logger.debug 'before save'
  end
  before_update -> { logger.debug 'before_update' }
  before_create lambda { logger.debug 'before_create' }
  # around_create -> { logger.debug 'around_create' }

  after_create -> { logger.debug 'after_create' }
  after_update -> { logger.debug 'after_update' }
  after_save -> { logger.debug 'after_save' }
  after_commit -> { logger.debug 'after_commit' }
  after_rollback -> { logger.debug 'after_rollback' }
  after_find -> { logger.debug 'after find' }
  after_touch -> { logger.debug 'after touch' }

  before_destroy -> { logger.debug 'before destroy' }
  after_destroy -> { logger.debug 'after destroy' }

  private
  def call_this_before
    logger.debug 'before validate'
  end

  def some_around
    logger.debug "before around"
    yield
    logger.debug "after around"
  end
end
