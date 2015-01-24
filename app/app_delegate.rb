#---
# Excerpted from "RubyMotion",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/carubym for more book information.
#---
class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.backgroundColor = UIColor.whiteColor
    @window.makeKeyAndVisible

    @blue_view = UIView.alloc.initWithFrame(CGRect.new([10, 40], [100, 100]))
    @blue_view.backgroundColor = UIColor.blueColor
    @window.addSubview(@blue_view)

    @add_button = UIButton.buttonWithType(UIButtonTypeSystem)
    @add_button.setTitle("Add", forState:UIControlStateNormal)
    @add_button.sizeToFit
    @add_button.frame = CGRect.new(
      [10, @window.frame.size.height - 10 - @add_button.frame.size.height],
      @add_button.frame.size)
    @window.addSubview(@add_button)

    @add_button.addTarget(
      self, action:"add_tapped", forControlEvents:UIControlEventTouchUpInside)
    @remove_button = UIButton.buttonWithType(UIButtonTypeSystem)
    @remove_button.setTitle("Remove", forState:UIControlStateNormal)
    @remove_button.sizeToFit
    @remove_button.frame = CGRect.new(
      [@add_button.frame.origin.x + @add_button.frame.size.width + 10,
        @add_button.frame.origin.y],
      @remove_button.frame.size)
    @window.addSubview(@remove_button)
    @remove_button.addTarget(
      self, action:"remove_tapped",
      forControlEvents:UIControlEventTouchUpInside)
    true
  end

  def add_tapped
    new_view = UIView.alloc.initWithFrame(CGRect.new([0, 0], [100, 100]))
    new_view.backgroundColor = UIColor.blueColor

    last_view = @window.subviews[0]
    new_view.frame = CGRect.new(
      [last_view.frame.origin.x,
        last_view.frame.origin.y + last_view.frame.size.height + 10],
      last_view.frame.size)
    @window.insertSubview(new_view, atIndex:0)
  end

  def remove_tapped
    other_views = @window.subviews.reject { |view|
      view.is_a?(UIButton)
    }
    last_view = other_views.last
    return unless last_view && other_views.count > 1

    animations_block = lambda {
      last_view.alpha = 0
      last_view.backgroundColor = UIColor.redColor
      other_views.reject { |view|
        view == last_view
      }.each { |view|
        new_origin = [
          view.frame.origin.x,
          view.frame.origin.y - (last_view.frame.size.height + 10)
        ]
        view.frame = CGRect.new(
          new_origin,
          view.frame.size)
      }
    }
    completion_block = lambda { |finished|
      last_view.removeFromSuperview
    }
    UIView.animateWithDuration(0.5,
      animations: animations_block,
      completion: completion_block)
  end
end
