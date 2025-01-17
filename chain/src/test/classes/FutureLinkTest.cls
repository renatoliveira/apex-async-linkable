@isTest
public class FutureLinkTest extends FutureLink {
  public FutureLinkTest() {
    super();
  }

  public FutureLinkTest(final boolean canBreak) {
    this();
    this.canBreak = canBreak;
  }

  protected override void job() {
    if (this.canBreak == true) {
      throw new FutureLinkException();
    }
  }

  public class FutureLinkException extends Exception {
  }

  @isTest
  static void testFail() {
    final AsyncLinkable anAsyncLinkable = new FutureLinkTest(true);

    test.startTest();
    try {
      anAsyncLinkable.job();
      System.Assert(false, 'should not be executed');
    } catch (FutureLinkException ex) {
      System.AssertNotEquals(null, ex, 'Exception should be thrown');
    }
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    final AsyncLinkable anAsyncLinkable = new FutureLinkTest();

    test.startTest();
    anAsyncLinkable.spawn();
    System.AssertNotEquals(0, Limits.getFutureCalls(), 'Should not be 0');
    test.stopTest();
  }
}
