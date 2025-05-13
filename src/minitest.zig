//:________________________________________________________________________
//  minitest  |  Copyright (C) Ivan Mar (sOkam!)  |  GNU LGPLv3 or later  :
//:________________________________________________________________________
pub const minitest = @This();
// @deps std
const std = @import("std");


//______________________________________
// @section Types
//____________________________
pub const string = []const u8;
pub const Fn     = fn () anyerror!void;


//______________________________________
// @section Forward Exports
//____________________________
pub const A      = std.testing.allocator;
pub const ok     = std.testing.expect;
pub const err    = std.testing.expectError;
pub const log    = struct {
  pub const info = std.debug.print;
};
pub fn eq     (value :anytype, expected :anytype) !void { try std.testing.expectEqual(expected, value); }
pub fn eq_str (value :anytype, expected :anytype) !void { try std.testing.expectEqualStrings(expected, value); }
pub const not = struct {
  pub fn ok (value :bool) !void { try minitest.ok(!value); }
  pub fn eq (value :anytype, expected :anytype) !void { try minitest.ok(minitest.check.not.eq(value, expected)); }
  pub fn eq_str (value :anytype, expected :anytype) !void { try minitest.not.ok(std.mem.eql(@TypeOf(value[0]), value, expected)); }
};


//______________________________________
// @section Boolean Checks
//____________________________
pub const check = struct {
  pub fn eq (value :anytype, expected :anytype) bool { switch (@typeInfo(@TypeOf(value))) {
    .pointer => return std.mem.eql(@TypeOf(value[0]), expected, value),
    .void    => return @TypeOf(value) == @TypeOf(expected),
    else     => return value == expected,
  }}
  pub const not = struct {
    pub fn eq (value :anytype, expected :anytype) bool { return !minitest.check.eq(value, expected); }
  };
};

//______________________________________
// @section Configuration
//____________________________
const Prefix = struct {
  const pass = " ✓  ";
  const skip = "    ";
  const todo = " ?  ";
  const fail = "[𐄂] ";
  const name = "[߹] minitest";
  const cli  = minitest.Prefix.name++": ";
};

//______________________________________
// @section Title Tools
//____________________________
var currentID :?*u32= null;
fn incr () void { currentID.?.* = if (currentID == null) 0 else currentID.?.* + 1; }
//__________________
pub const Title = struct {
  data :minitest.string,
  id   :u32= 0,
  pub fn create (data :minitest.string) minitest.Title { return .{.data= data}; }
  pub fn begin (T :*minitest.Title) void { minitest.log.info("{s}Testing {s} ...\n",   .{minitest.Prefix.cli, T.data}); currentID = &T.id; }
  pub fn end   (T :*minitest.Title) void { minitest.log.info("{s}Done testing {s}.\n", .{minitest.Prefix.cli, T.data}); currentID = null; }
};
pub const title = Title.create;

//______________________________________
// @section Describe Tools
//____________________________
fn pass  (comptime msg :minitest.string) void { minitest.log.info("{s}{?d:0>2} | {s}\n", .{minitest.Prefix.pass, currentID.?.*, msg}); }
fn _skip (comptime msg :minitest.string) void { minitest.log.info("{s}{?d:0>2} [skip] | {s}\n", .{minitest.Prefix.skip, currentID.?.*, msg}); }
fn _todo (comptime msg :minitest.string) void { minitest.log.info("{s}[todo] {s}\n", .{minitest.Prefix.todo, msg}); }
fn fail  (e :anyerror, comptime msg :minitest.string) anyerror { minitest.log.info("{s}{s}: {?d:0>2} | {s}\n", .{minitest.Prefix.fail, @errorName(e), currentID.?.*, msg}); return e; }

pub fn it (
    comptime msg       : minitest.string,
    comptime statement : minitest.Fn,
  ) !void {
  minitest.incr();
  statement() catch |e| { return minitest.fail(e, msg); };
  minitest.pass(msg);
}

pub const skip = struct {
  pub fn it (
      comptime msg : minitest.string,
      comptime _   : minitest.Fn,
    ) !void {
    minitest.incr();
    minitest._skip(msg);
  }
};

pub const todo = struct {
  pub fn it (
      comptime msg : minitest.string,
      comptime _   : minitest.Fn,
    ) !void {
    minitest.incr();
    minitest._todo(msg);
  }
};

pub const hide = struct {
  pub fn it (
      comptime _: minitest.string,
      comptime _: minitest.Fn,
    ) !void {
    minitest.incr();
  }
};

